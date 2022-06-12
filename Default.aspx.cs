using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.Entity.Core.Objects;

namespace CRUD
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod] 
        public static List<Company> getCompany()
        {
            List<Company> results;
            using (CRUDEntities context = new CRUDEntities())
            {
                context.Configuration.LazyLoadingEnabled = false;
                results = context.Companies.OrderByDescending(x => x.IdC).ToList();
            }
            return results;
        }

        [WebMethod] 
        public static string addCompany(string name, string infor)
        {
            ObjectParameter id = new ObjectParameter("Id", typeof(string));
            using (CRUDEntities context = new CRUDEntities())
            {
                context.AddCompany(name, infor, id);
            }
            return Convert.ToString(id.Value);
        }

        [WebMethod]
        public static void delCompany(string id)
        {
            using (CRUDEntities context = new CRUDEntities())
            {
                context.DelCompany(id);
            }
        }

        [WebMethod]
        public static void editCompany(string id, string name, string infor)
        {
            using (CRUDEntities context = new CRUDEntities())
            {
                context.EditCompany(id, name, infor);
            }
        }

        [WebMethod]
        public static List<Staff> getStaff(string id)
        {
            List<Staff> results;
            using (CRUDEntities context = new CRUDEntities())
            {
                context.Configuration.LazyLoadingEnabled = false;
                results = context.Staffs.Where(x => x.Company == id).OrderByDescending(x => x.IdS).ToList();
            }
            return results;
        }

        [WebMethod]
        public static string addStaff(string name, string company)
        {
            ObjectParameter id = new ObjectParameter("Id", typeof(string));
            using (CRUDEntities context = new CRUDEntities())
            {
                context.AddStaff(name, company,id);
            }
            return Convert.ToString(id.Value);
        }

        [WebMethod]
        public static void delStaff(string id)
        {
            using (CRUDEntities context = new CRUDEntities())
            {
                context.DelStaff(id);
            }
        }

        [WebMethod]
        public static void editStaff(string id, string name, string company)
        {
            using (CRUDEntities context = new CRUDEntities())
            {
                context.EditStaff(id, name, company);
            }
        }
    }
}