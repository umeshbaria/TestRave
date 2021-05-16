using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using TestRave.Models;

namespace TestRave.Repository
{
    public class IncidentRepository : IIncidentRepository
    {
        string ConnString = ConfigurationManager.ConnectionStrings["CityIncidentConnString"].ConnectionString;
        public IncidentRepository()
        {

        }

        public int Add(Incident item)
        {
            int res = 0;
            using (SqlConnection con = new SqlConnection(ConnString))
            {
                SqlCommand cmd = new SqlCommand("spAddIncident", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.Parameters.AddWithValue("@Title", item.Title);
                cmd.Parameters.AddWithValue("@IncidentDate", item.IncidentDate);
                cmd.Parameters.AddWithValue("@IncidentType", item.IncidentType);
                cmd.Parameters.AddWithValue("@Description", item.Description);
                cmd.Parameters.AddWithValue("@Address", item.Address);
                cmd.Parameters.AddWithValue("@PinCode", item.PinCode);
                cmd.Parameters.AddWithValue("@State", item.State);
                cmd.Parameters.AddWithValue("@County", item.County);
                cmd.Parameters.AddWithValue("@City", item.City);
                cmd.Parameters.AddWithValue("@Latitude", item.Latitude);
                cmd.Parameters.AddWithValue("@Longitude", item.Longitude);
                res = cmd.ExecuteNonQuery();
            }
            return res;
        }

        public IEnumerable<DisplayIncident> GetAll()
        {
            List<DisplayIncident> incidents = new List<DisplayIncident>();
            using (SqlConnection con = new SqlConnection(ConnString))
            {
                SqlCommand cmd = new SqlCommand("spGetAllIncident", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    incidents.Add(new DisplayIncident
                    {
                        IncidentNo = sdr["IncidentNo"].ToString(),
                        Address = sdr["Address"].ToString(),
                        Description = sdr["Description"].ToString(),
                        IncidentDate = Convert.ToDateTime(sdr["IncidentDate"].ToString()),
                        IncidentType = sdr["IncidentType"].ToString(),
                        Title = sdr["Title"].ToString()
                    });

                }
            }
            return incidents;
        }

        public string GetGoogleMapMarkers()
        {
            string markers = "[";
            using (SqlConnection con = new SqlConnection(ConnString))
            {
                SqlCommand cmd = new SqlCommand("spGetMap", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    markers += "{";
                    markers += string.Format("'title': '{0}',", sdr["CityName"]);
                    markers += string.Format("'lat': '{0}',", sdr["Latitude"]);
                    markers += string.Format("'lng': '{0}',", sdr["Longitude"]);
                    markers += string.Format("'description': '{0}'", sdr["Description"]);
                    markers += "},";
                }
            }
            markers += "];";
            return markers;
        }

        public IEnumerable<IncidentType> GetIncidentTypes()
        {
            List<IncidentType> incidentTypes = new List<IncidentType>();
            using (SqlConnection con = new SqlConnection(ConnString))
            {
                SqlCommand cmd = new SqlCommand("spGetIncidentType", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    incidentTypes.Add(new IncidentType
                    {
                        Id = Convert.ToInt32(sdr["Id"]),
                        Name = sdr["Name"].ToString()
                    });
                }
            }
            return incidentTypes;
        }
    }
}