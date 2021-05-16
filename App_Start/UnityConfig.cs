using System.Web.Mvc;
using TestRave.Repository;
using Unity;
using Unity.Mvc5;

namespace TestRave
{
    public static class UnityConfig
    {
        public static void RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();
            container.RegisterType<IIncidentRepository, IncidentRepository>();
            DependencyResolver.SetResolver(new UnityDependencyResolver(container));
        }
    }
}