/* ===== Sistema Académico - comportamiento de la interfaz ===== */
(function () {
    var raiz = document.documentElement;

    // Tema claro/oscuro: respeta el del sistema hasta que el usuario elige uno
    var botonTema = document.getElementById("tema");
    if (botonTema) {
        botonTema.addEventListener("click", function () {
            var oscuroActual = raiz.dataset.theme
                ? raiz.dataset.theme === "dark"
                : window.matchMedia("(prefers-color-scheme: dark)").matches;
            raiz.dataset.theme = oscuroActual ? "light" : "dark";
            try { localStorage.setItem("tema", raiz.dataset.theme); } catch (e) {}
        });
    }

    // Buscador: <input data-filtro="#idLista"> filtra los elementos [data-buscar] de esa lista
    document.querySelectorAll("[data-filtro]").forEach(function (input) {
        var lista = document.querySelector(input.dataset.filtro);
        if (!lista) return;
        var sinResultados = lista.closest(".card").querySelector(".sin-resultados");
        input.addEventListener("input", function () {
            var texto = input.value.trim().toLowerCase();
            var visibles = 0;
            lista.querySelectorAll("[data-buscar]").forEach(function (fila) {
                var coincide = fila.dataset.buscar.toLowerCase().indexOf(texto) !== -1;
                fila.hidden = !coincide;
                if (coincide) visibles++;
            });
            if (sinResultados) sinResultados.hidden = visibles > 0;
        });
    });

    // Confirmación antes de enviar formularios destructivos
    document.querySelectorAll("form[data-confirmar]").forEach(function (form) {
        form.addEventListener("submit", function (e) {
            if (!window.confirm(form.dataset.confirmar)) e.preventDefault();
        });
    });

    // Alertas: se pueden cerrar y las de éxito se van solas
    document.querySelectorAll(".alerta").forEach(function (alerta) {
        var cerrar = function () {
            alerta.classList.add("saliendo");
            setTimeout(function () { alerta.remove(); }, 250);
        };
        var boton = alerta.querySelector(".alerta-cerrar");
        if (boton) boton.addEventListener("click", cerrar);
        if (alerta.classList.contains("ok")) setTimeout(cerrar, 4500);
    });

    // Saca el ?ok=... de la URL para que el mensaje no reaparezca al recargar
    if (window.history.replaceState && /[?&]ok=/.test(location.search)) {
        var url = new URL(location.href);
        url.searchParams.delete("ok");
        url.searchParams.delete("id");
        history.replaceState(null, "", url.pathname + url.search + url.hash);
    }
})();
