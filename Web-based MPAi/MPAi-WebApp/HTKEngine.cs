using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Configuration;

namespace MPAi_WebApp
{
    /// <summary>
    /// Class that handles the HTK speech recognition funtionality.
    /// A large portion of this code was written prior to the project that added this documentation.
    /// As a result, this documentation may be limited.
    /// </summary>
    class HTKEngine
    {
        /// <summary>
        /// Starts a process running the specified HTK batch file, and passes it the arguments.
        /// This is specifically designed for the ModelEvaluater.bat [sic] script.
        /// </summary>            
        /// <param name="filePath">The path to the batch file to run.</param>           
        /// <param name="arguments">The arguments. These will be written to the console once the application starts.</param>
        public void RunBatchFile(string filePath, string arguments = "")
        {
            if (!File.Exists(filePath)) return;
            try
            {
                // Start batch process in the background.
                ProcessStartInfo processInfo = new ProcessStartInfo(filePath);
                processInfo.CreateNoWindow = true;
                processInfo.UseShellExecute = false;

                // Set the process working directory. This sets it to the HTK/Batches directory in this project.
                // Some tweaks may be required to use this method in other contexts.
                string htkFolder = ConfigurationManager.AppSettings["HTKFolder"].Replace("./", AppDomain.CurrentDomain.BaseDirectory);
                processInfo.WorkingDirectory = Path.Combine(htkFolder, "Batches");
                
                // Redirect the output
                processInfo.RedirectStandardError = true;
                processInfo.RedirectStandardOutput = true;
                processInfo.RedirectStandardInput = true;

                // Run the process and pass in the arguments
                Process process = Process.Start(processInfo);
                process.StandardInput.WriteLine(arguments);

                //Run process sequentially
                process.WaitForExit();
            }
            catch (Exception exp)
            {
                Console.WriteLine(exp);
            }
        }

        /// <summary>
        /// Called externally to analyse a recording.
        /// </summary>
        /// <param name="RecordingPath">The path to the wav file to recognise a recording.</param>
        /// <returns>A dictionary containing the filename in the key field and the analysis results in the value field.</returns>
        public IDictionary<string, string> Recognize(String RecordingPath)
        {
            string htkFolder = ConfigurationManager.AppSettings["HTKFolder"].Replace("./", AppDomain.CurrentDomain.BaseDirectory);

            string BatchesFolder = Path.Combine(htkFolder, @"Batches");
            string MLFsFolder = Path.Combine(htkFolder, @"MLFs");
            RunBatchFile(Path.Combine(BatchesFolder, "ModelEvaluater.bat"), RecordingPath);
            return Analyze(Path.Combine(MLFsFolder, "RecMLF.mlf"));
        }

        /// <summary>
        /// Parses the file that HTK writes results into (usually HTK/MLFs/RecMLF.mlf) into a dictionary object.
        /// </summary>
        /// <param name="ResultPath">The path the the output file</params>
        /// <returns>A dictionary containing the filename in the key field and the analysis results in the value field.</returns>
        public IDictionary<string, string> Analyze(String ResultPath)
        {
            Dictionary<String, String> RecResult = new Dictionary<string, string>();
            if (File.Exists(ResultPath))
            {
                try
                {
                    using (FileStream fs = File.OpenRead(ResultPath))
                    {
                        using (StreamReader sr = new StreamReader(fs))
                        {
                            string line;
                            Match m = Match.Empty;
                            string index = string.Empty;
                            string result = string.Empty;
                            while ((line = sr.ReadLine()) != null)
                            {
                                if ((m = Regex.Match(line, @"(?<="")(?:\\.|[^""\\])*(?="")")).Success)
                                {
                                    index = m.Value;
                                }
                                else if (Regex.Match(line, @"\.$").Success)
                                {
                                    RecResult.Add(index.TrimStart('*', '/'), ResultModifier.LetterReplace(result.TrimEnd(' ')));
                                    m = Match.Empty;
                                    index = string.Empty;
                                    result = string.Empty;
                                }
                                else if (line != "#!MLF!#")
                                {
                                    result += line + " ";
                                }
                            }
                        }
                    }
                }
                catch (Exception exp)
                {
                    Console.WriteLine(exp);
                }
            }
            return RecResult;
        }
    }

    /// <summary>
    /// Static class to convert macron letters to char values, and vice versa. 
    /// Used by the HTK engine to resolve encoding issues.
    /// <summary>
    public static class ResultModifier
    {
        public static string LetterReplace(string value)
        {
            value = value.Replace(@"\344", @"ä").Replace(@"\353", @"ë").Replace(@"\357", @"ï").Replace(@"\366", @"ö").Replace(@"\374", @"ü");
            return value;
        }
    }
}
