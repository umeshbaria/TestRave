using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace TestRave.Models
{
    public class Incident
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please enter incident title")]
        [Display(Name = "Incident Title")]
        public string Title { get; set; }

        public int MapId { get; set; }

        [Required(ErrorMessage = "Please select incident type ")]
        [Display(Name = "Incident Type")]
        public string IncidentType { get; set; }

        public string Description { get; set; }

        [Required(ErrorMessage = "Please enter Incident Date ")]
        [Display(Name = "Incident Date")]
        public DateTime IncidentDate { get; set; }

        public string Address { get; set; }
        public string County { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        [Display(Name = "Pincode")]
        public string PinCode { get; set; }

        public string Latitude { get; set; }
        public string Longitude { get; set; }
    }
}