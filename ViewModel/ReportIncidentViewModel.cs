using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using TestRave.Models;

namespace TestRave.ViewModel
{
    public class ReportIncidentViewModel
    {
        public ReportIncidentViewModel()
        {
            IncidentTypes = new List<IncidentType>();
        }
        public int Id { get; set; }

        [Required(ErrorMessage = "Please enter incident title")]
        [Display(Name = "Incident Title")]
        public string Title { get; set; }

        [Required(ErrorMessage = "Please select incident type ")]
        [Display(Name = "Incident Type")]
        public string IncidentType { get; set; }

        public string Description { get; set; }

        [Required(ErrorMessage = "Please enter Incident Date ")]
        [Display(Name = "Incident Date")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime IncidentDate { get; set; } = DateTime.Now;

        [Required(ErrorMessage = "Please enter address")]
        public string Address { get; set; }
        public string County { get; set; }
        public string State { get; set; }
        public string City { get; set; }

        [DataType(DataType.PostalCode)]
        public string PinCode { get; set; }

        // non-table propery
        public List<IncidentType> IncidentTypes { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }

        public static implicit operator ReportIncidentViewModel(Incident incident)
        {
            return new ReportIncidentViewModel
            {
                Id = incident.Id,
                City = incident.City,
                County = incident.County,
                Description = incident.Description,
                IncidentDate = incident.IncidentDate,
                IncidentType = incident.IncidentType,
                Address = incident.Address,
                PinCode = incident.PinCode,
                State = incident.State,
                Title = incident.Title,
                Latitude = incident.Latitude,
                Longitude = incident.Longitude
            };
        }

        public static implicit operator Incident(ReportIncidentViewModel vm)
        {
            return new Incident
            {
                Id = vm.Id,
                City = vm.City,
                County = vm.County,
                Description = vm.Description,
                IncidentDate = vm.IncidentDate,
                IncidentType = vm.IncidentType,
                PinCode = vm.PinCode,
                Address = vm.Address,
                State = vm.State,
                Title = vm.Title,
                Longitude = vm.Longitude,
                Latitude = vm.Latitude
            };
        }
    }
}