function geocomp(balise) {
        $('#'+balise)
            .geocomplete({details: "form", detailsAttribute: "data-geo"})
            .bind("geocode:result", function(event, result){
                console.log(result)
            });
}
