adminModuleContent = null;
$(document).ready(function () {
    // Cargar los archivos CSS
    loadCss("/Modules/AdminView/Style/mainAdminView.css", function () { });
    // Cargar los archivos JS
    loadScript("/Modules/AdminView/Script/generalFunctions.js", function () { });
    loadScript("/Modules/AdminView/Script/adminModuleContent.js", function(){ adminModuleContent = new AdminModuleContent(); });
    loadScript("/Modules/AdminView/Script/menuMainAdmin.js", function () { });
    loadScript("/Modules/AdminView/Script/mainAdminViewAjax.js", function () { });
    loadScript("/Modules/AdminView/Script/actualizarRadicado.js", function () { });
    // Bloquear el click en el evento para que no intente recargar la pagina
    $("button").click(function(event) { event.preventDefault(); });
    $("a").click(function(event) { event.preventDefault(); });
});

//Funcion para cargar dinamicamente un archivo JS 
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

//Funcion para cargar dinamicamente un archivo CSS
function loadCss(url, callback) {
    // Crear un ID único basado en la URL del CSS
    var cssId = 'css-' + url.replace(/[/:.]/g, '-');
    // Eliminar el CSS antiguo si existe
    var oldCss = document.getElementById(cssId);
    if (oldCss) {
        oldCss.parentNode.removeChild(oldCss);
    }
    // Crear un nuevo enlace CSS
    var css = document.createElement("link");
    css.rel = "stylesheet";
    css.id = cssId;  // Añadir el ID al CSS
    css.href = url;
    if (css.readyState){  //IE
        css.onreadystatechange = function(){
            if (css.readyState == "loaded" ||
                    css.readyState == "complete"){
                css.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        css.onload = function(){
            callback();
        };
    }
    document.getElementsByTagName("head")[0].appendChild(css);
}
