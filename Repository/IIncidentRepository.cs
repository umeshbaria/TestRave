using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TestRave.Models;

namespace TestRave.Repository
{
    public interface IIncidentRepository
    {
        IEnumerable<DisplayIncident> GetAll();
        int Add(Incident item);
        IEnumerable<IncidentType> GetIncidentTypes();
        string GetGoogleMapMarkers();
    }
}
