using Microsoft.AspNetCore.Hosting.Server.Features;
using Microsoft.AspNetCore.Hosting.Server;

namespace MvcCoreProyectoSejo.Helpers
{
    public enum Folders { Eventos = 0, Usuarios = 1 }
    public class HelperPathProvider
    {
        //NECESITAMOS ACCEDER AL SISTEMA DE ARCHIVOS DEL WEB SERVER (wwwroot) 
        private IServer server;
        public HelperPathProvider(IServer server)
        {
            this.server = server;
        }

        public string GetFolderPath(Folders folder)
        {
            string carpeta = "";
            if (folder == Folders.Eventos)
            {
                carpeta = "eventos";
            }
            else if (folder == Folders.Usuarios)
            {
                carpeta = "usuarios";
            }

            return carpeta;
        }
        public string MapUrlPath(string fileName, Folders folder)
        {
            string carpeta = this.GetFolderPath(folder);
            var addresses = server.Features.Get<IServerAddressesFeature>().Addresses;
            string serverUrl = addresses.FirstOrDefault();
            string urlPath = serverUrl + "/" + carpeta + "/" + fileName;
            return urlPath;
        }

        public string MapUrlServerPath()
        {
            var addresses = server.Features.Get<IServerAddressesFeature>().Addresses;
            string serverUrl = addresses.FirstOrDefault();
            return serverUrl;
        }
    }
}

