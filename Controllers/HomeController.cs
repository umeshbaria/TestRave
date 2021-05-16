using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TestRave.Models;
using TestRave.Repository;
using TestRave.ViewModel;

namespace TestRave.Controllers
{
    public class HomeController : Controller
    {
        readonly IIncidentRepository incidentRepository;
        public HomeController(IIncidentRepository repository)
        {
            this.incidentRepository = repository;
        }

        /// <summary>
        /// Get - Index
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            string markers = incidentRepository.GetGoogleMapMarkers();
            ViewBag.Markers = markers;
            return View(incidentRepository.GetAll());
        }

        /// <summary>
        /// Get - Report Incident
        /// </summary>
        /// <returns></returns>
        public ActionResult ReportIncident()
        {
            ReportIncidentViewModel incident = new ReportIncidentViewModel();
            incident.IncidentTypes = incidentRepository.GetIncidentTypes().ToList();
            return View(incident);
        }   

        /// <summary>
        /// Post - Report Incident
        /// </summary>
        /// <param name="incident"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ReportIncident(ReportIncidentViewModel incident)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    incidentRepository.Add(incident);
                }
                catch (Exception ex)
                {
                    ViewBag.Message = "Error";
                }
            }
            else
            {
                incident.IncidentTypes = incidentRepository.GetIncidentTypes().ToList();
                return View(incident);
            }
            ViewBag.Message = "Success";
            return RedirectToAction("Index");
        }

    }
}