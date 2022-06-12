﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CRUD
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class CRUDEntities : DbContext
    {
        public CRUDEntities()
            : base("name=CRUDEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Company> Companies { get; set; }
        public virtual DbSet<Staff> Staffs { get; set; }
    
        public virtual int AddCompany(string nameC, string infor, ObjectParameter id)
        {
            var nameCParameter = nameC != null ?
                new ObjectParameter("NameC", nameC) :
                new ObjectParameter("NameC", typeof(string));
    
            var inforParameter = infor != null ?
                new ObjectParameter("Infor", infor) :
                new ObjectParameter("Infor", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddCompany", nameCParameter, inforParameter, id);
        }
    
        public virtual int AddStaff(string nameS, string company, ObjectParameter id)
        {
            var nameSParameter = nameS != null ?
                new ObjectParameter("NameS", nameS) :
                new ObjectParameter("NameS", typeof(string));
    
            var companyParameter = company != null ?
                new ObjectParameter("Company", company) :
                new ObjectParameter("Company", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddStaff", nameSParameter, companyParameter, id);
        }
    
        public virtual int DelCompany(string idC)
        {
            var idCParameter = idC != null ?
                new ObjectParameter("IdC", idC) :
                new ObjectParameter("IdC", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DelCompany", idCParameter);
        }
    
        public virtual int DelStaff(string idS)
        {
            var idSParameter = idS != null ?
                new ObjectParameter("IdS", idS) :
                new ObjectParameter("IdS", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DelStaff", idSParameter);
        }
    
        public virtual int EditCompany(string idC, string nameC, string infor)
        {
            var idCParameter = idC != null ?
                new ObjectParameter("IdC", idC) :
                new ObjectParameter("IdC", typeof(string));
    
            var nameCParameter = nameC != null ?
                new ObjectParameter("NameC", nameC) :
                new ObjectParameter("NameC", typeof(string));
    
            var inforParameter = infor != null ?
                new ObjectParameter("Infor", infor) :
                new ObjectParameter("Infor", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("EditCompany", idCParameter, nameCParameter, inforParameter);
        }
    
        public virtual int EditStaff(string idS, string nameS, string company)
        {
            var idSParameter = idS != null ?
                new ObjectParameter("IdS", idS) :
                new ObjectParameter("IdS", typeof(string));
    
            var nameSParameter = nameS != null ?
                new ObjectParameter("NameS", nameS) :
                new ObjectParameter("NameS", typeof(string));
    
            var companyParameter = company != null ?
                new ObjectParameter("Company", company) :
                new ObjectParameter("Company", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("EditStaff", idSParameter, nameSParameter, companyParameter);
        }
    }
}
