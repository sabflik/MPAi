using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;

namespace UploadRecording.DataModel
{
    public class MPAiContext : DbContext
    {

        private String path = "C:\\Users\\adm.Jayden\\Work Folders\\Documents\\MPAiDatabase";
        public string Path { get => path; set => path = value; }

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
        public virtual DbSet<Recording> Recording { get; set; }
        public virtual DbSet<Score> Score { get; set; }
        public virtual DbSet<User> User { get; set; }
        public virtual DbSet<Word> Word { get; set; }

        public static MPAiContext InitializeDBModel()
        {
            MPAiContext DBModel;
            DBModel = new MPAiContext();
            DBModel.Database.Initialize(false);
            DBModel.Recording.Load();
            DBModel.Score.Load();
            DBModel.User.Load();
            DBModel.Word.Load();
            return DBModel;
        }

        public void AddOrUpdateRecordingFile(String filePath)
        {
            // Dynamically create recordings and words.
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