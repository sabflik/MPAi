using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.IO;
using System.Linq;
using System.Web;

namespace UploadRecording.DataModel
{
    public class MPAiContext : DbContext
    {
        private String path = "C:\\Users\\adm.Jayden\\Work Folders\\Documents\\MPAiDatabase";
        public string Path
        {
            get
            {
                return path;
            }
            set
            {
                path = value;
            }
        }

        public MPAiContext() : base("name=MPAiModel")
        {
            if (!Directory.Exists(System.IO.Path.Combine(Path, "Database")))
            {
                Directory.CreateDirectory(System.IO.Path.Combine(Path, "Database"));
            }
            AppDomain.CurrentDomain.SetData("DataDirectory", System.IO.Path.Combine(Path, "Database"));

            Database.SetInitializer<MPAiContext>(new MPAiContextInitializer());
        }

        // Variables representing the set of values taken out of the database.
        public virtual DbSet<Recording> RecordingSet { get; set; }
        public virtual DbSet<Score> ScoreSet { get; set; }
        public virtual DbSet<User> UserSet { get; set; }
        public virtual DbSet<Word> WordSet { get; set; }

        public static MPAiContext InitializeDBModel()
        {
            MPAiContext DBModel;
            DBModel = new MPAiContext();
            DBModel.Database.Initialize(false);
            DBModel.RecordingSet.Load();
            DBModel.ScoreSet.Load();
            DBModel.UserSet.Load();
            DBModel.WordSet.Load();
            return DBModel;
        }

        public void AddOrUpdateRecordingFile(String filePath)
        {
            // Dynamically create recordings and words.
            // Move parsing to a class later
            String fileName = System.IO.Path.GetFileName(filePath);
            // Filenames are always in the format speaker-category-name-label.wav
            String wordName = fileName.Split('-')[2];
            Speaker? speaker;
            switch (fileName.Split('-')[0])
            {
                case ("oldfemale"):
                    speaker = Speaker.KUIA_FEMALE;
                    break;
                case ("oldmale"):
                    speaker = Speaker.KAUMATUA_MALE;
                    break;
                case ("youngfemale"):
                    speaker = Speaker.MODERN_FEMALE;
                    break;
                case ("youngmale"):
                    speaker = Speaker.MODERN_MALE;
                    break;
                default:
                    speaker = null;
                    break;
            }
            // Create the word if it doesn't exist, get the name from the filename.
            Word newWord = WordSet.SingleOrDefault(x => x.Name.Equals(wordName));
            if (newWord == null)
            {
                newWord = new Word()
                {
                    Name = wordName
                };

                WordSet.AddOrUpdate(x => x.Name, newWord);
                SaveChanges();
            }
            // Create the recording if it doesn't exist, associate it with the Word.
            Recording newRecording = RecordingSet.SingleOrDefault(x => x.FilePath.Equals(filePath));
            if (newRecording == null)
            {
                newWord = WordSet.SingleOrDefault(x => x.Name.Equals(newWord.Name));
                newRecording = new Recording()
                {
                    FilePath = filePath,
                    Speaker = (Speaker)speaker,
                    Word = newWord
                };
                RecordingSet.AddOrUpdate(x => x.FilePath, newRecording);

                newWord.Recordings.Add(newRecording);
                WordSet.AddOrUpdate(x => x.Name, newWord);

                SaveChanges();
            }
        }
    }

    public class MPAiContextInitializer : CreateDatabaseIfNotExists<MPAiContext>
    {
        private string AudioFolder = "C:\\Users\\adm.Jayden\\Work Folders\\Documents\\GitHub\\SabFlik\\MPAi\\Web-based MPAi\\UploadRecording\\Audio";

        /// <summary>
        /// If the database doesn't exist, it is created.
        /// If it does exist, and the Audio folder a) exists and b) contains at least one .wav file, then
        /// Each .wav file is added to the database, or updated if it is already in the database. 
        /// </summary>
        /// <param name="context">The current MPAiModel object representing the persistence context.</param>
        protected override void Seed(MPAiContext context)
        {
            if (Directory.Exists(AudioFolder))
            {
                DirectoryInfo dirInfo = new DirectoryInfo(AudioFolder);
                // Note that this isn't super scalable. Shouldn't hard code .wav
                foreach (FileInfo fInfo in dirInfo.GetFiles("*.wav", SearchOption.AllDirectories))   // Also searches subdirectories.
                {
                    if (fInfo.Extension.Contains("wav"))
                    {
                        context.AddOrUpdateRecordingFile(Path.Combine(fInfo.DirectoryName, fInfo.FullName));
                    }
                }
            }
            base.Seed(context); // Does nothing. There is no Audio folder, so nothing to add or update.
        }
    }
}