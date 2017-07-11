using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UploadRecording.DataModel
{
    /// <summary>
    /// Enum representing the speaker of a recording. 
    /// Unidentified speakers will not be used when a specific speaker is requested, but will still show without error when all words are listed.
    /// </summary>
    public enum Speaker
    {
        KAUMATUA_MALE, KUIA_FEMALE, MODERN_MALE, MODERN_FEMALE, UNIDENTIFIED
    }
}