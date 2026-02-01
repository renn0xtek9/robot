document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".mermaid svg").forEach(svg => {
        svgPanZoom(svg, {
            zoomEnabled: true,
            controlIconsEnabled: true,
            fit: true,
            center: true,
            minZoom: 0.1,
            maxZoom: 50
        });
    });
});
