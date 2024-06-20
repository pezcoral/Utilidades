function loadScript(url, callback) {
    // Crear un ID único basado en la URL del script
    var scriptId = 'script-' + url.replace(/[/:.]/g, '-');

    // Eliminar el script antiguo si existe
    var oldScript = document.getElementById(scriptId);
    if (oldScript) {
        oldScript.parentNode.removeChild(oldScript);
    }

    // Crear un nuevo script
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.id = scriptId;  // Añadir el ID al script

    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" ||
                    script.readyState == "complete"){
                script.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        script.onload = function(){
            callback();
        };
    }
    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
}

$(document).ready(function () {
    loadScript("/Modules/AdminView/Script/adminModuleContent.js", function(){
        adminModuleContent = new AdminModuleContent();
    });
    loadScript("/Modules/AdminView/Script/adminModuleContent.js", function () { });
    loadScript("/Modules/AdminView/Script/menuMainAdmin.js", function () { });
    loadScript("/Modules/AdminView/Script/generalFunctions.js", function () { });
    loadScript("/Modules/AdminView/Script/mainAdminViewAjax.js", function () { });
    loadScript("/Modules/AdminView/Script/actualizarRadicado.js", function () { });
});
