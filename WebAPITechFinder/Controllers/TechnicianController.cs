using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TechFinderWebAPI.Controllers
{
    public class TechnicianController : ApiController
    {
        //// GET: api/Technician
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        // GET: api/Technician/5
        public string Get( string lat, string longitude, string skill)
        {
            //return  "value";
            DataAccessLayer obj = new DataAccessLayer();
            return JsonConvert.SerializeObject(obj.AccessDatabase(lat,longitude,skill));

                 
        }

        // POST: api/Technician
        public void Post([FromBody]string value)
        {

        }

        //// PUT: api/Technician/5
        //public void Put(int id, [FromBody]string value)
        //{
        //}

        //// DELETE: api/Technician/5
        //public void Delete(int id)
        //{
        //}
    }
}
