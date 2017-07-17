using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Migrations;
using System.IO;
using System.Linq;
using System.Web;

namespace MPAi_WebApp.DataModel
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
                // If the folder doesn't exist, create it and initialise the database.
                Directory.CreateDirectory(System.IO.Path.Combine(Path, "Database"));
                Database.SetInitializer<MPAiContext>(new MPAiContextInitializer());
            }
            else
            {
                // If the database folder exists, the database has already been created, and doesn't need intialising.
                Database.SetInitializer<MPAiContext>(null);
            }
            AppDomain.CurrentDomain.SetData("DataDirectory", System.IO.Path.Combine(Path, "Database"));
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

        /// <summary>
        /// Returns a Speaker object from the given file path, according to MPAi naming conventions.
        /// </summary>
        /// <param name="fileName">The recording file name</param>
        /// <returns>A speaker object representing the speaker of the recording.</returns>
        private Speaker SpeakerFromFile(String fileName)
        {
            switch (fileName.Split('-')[0])
            {
                case ("oldfemale"):
                    return Speaker.KUIA_FEMALE;
                case ("oldmale"):
                    return Speaker.KAUMATUA_MALE;
                case ("youngfemale"):
                    return Speaker.MODERN_FEMALE;
                case ("youngmale"):
                    return Speaker.MODERN_MALE;
                default:
                    return Speaker.UNIDENTIFIED;
            }
        }

        /// <summary>
        /// Returns a word from the given file path, according to MPAi naming conventions.
        /// </summary>
        /// <param name="fileName">The recording file name</param>
        /// <returns>A speaker object representing the speaker of the recording.</returns>
        private String WordNameFromFile(String fileName)
        {
            return fileName.Split('-')[2];
        }

        public void AddRecordingFileIfNotExists(String filePath)
        {
            // Dynamically create recordings and words.
            String fileName = System.IO.Path.GetFileName(filePath);
            String wordName = WordNameFromFile(fileName);
            Speaker speaker = SpeakerFromFile(fileName);
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
                    Speaker = speaker,
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
                        context.AddRecordingFileIfNotExists(Path.Combine(fInfo.DirectoryName, fInfo.FullName));
                    }
                }
            }
            base.Seed(context); // Does nothing. There is no Audio folder, so nothing to add or update.
        }
    }
}