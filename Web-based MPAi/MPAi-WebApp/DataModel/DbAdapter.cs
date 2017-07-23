using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace MPAi_WebApp.DataModel
{
    public static class DbAdapter
    {
        public static List<Recording> GenerateRecordingList(MPAiContext context, String name, String category)
        {
            Speaker speaker;
            if (!(Enum.TryParse(category, out speaker)))
            {
                speaker = Speaker.UNIDENTIFIED;
            }
            List<Recording> recordingList = context.RecordingSet.ToList().Where(x => x.Word.Name.Equals(name) && x.Speaker.Equals(speaker)).ToList();
            return recordingList;
        }

       public static List<Word> GenerateWordList(MPAiContext context)
        {
            List<Word> wordList = context.WordSet.ToList();
            return wordList;
        }
    }
}