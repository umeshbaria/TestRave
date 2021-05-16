using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TestRave.Models
{
    public class DisplayIncident
    {
        [Display(Name = "Incident No")]
        public string IncidentNo { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        [Display(Name = "Date")]
        public DateTime IncidentDate { get; set; }
        [Display(Name = "Incident Type")]
        public string IncidentType { get; set; }
        public string Address { get; set; }
    }
}