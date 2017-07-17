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
        public static DataTable GenerateAudioDataTable(MPAiContext context, String name, String category)
        {
            Word word = new Word() { Name = name };
            Speaker speaker;
            if (!(Enum.TryParse(category, out speaker)))
            {
                speaker = Speaker.UNIDENTIFIED;
            }
            List<Recording> recordingList = context.RecordingSet.ToList().Where(x => x.Word.Equals(word) && x.Speaker.Equals(speaker)).ToList();
            DataTable audioDataTable = ToDataTable(recordingList);
            return audioDataTable;
        }

        // From https://stackoverflow.com/questions/27738238/convert-dbcontext-to-datatable-in-code-first-entity-framework
        public static DataTable ToDataTable<T>(this IList<T> data)
        {
            PropertyDescriptorCollection properties =
                TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;
        }
    }
}