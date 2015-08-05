function address_complete() {
    $('#addressForm')
        .formValidation({
            framework: 'bootstrap',
            icon: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                address: {
                    trigger: 'blur',
                    validators: {
                        notEmpty: {
                            message: 'The address is required'
                        },
                        callback: {
                            message: 'The address is not found',
                            callback: function(value, validator, $field) {
                                var lat = $('#addressForm').find('[name="lat"]').val(),
                                    lng = $('#addressForm').find('[name="lng"]').val();
                                return $.isNumeric(lat) && $.isNumeric(lng)
                                        && (-90 <= lat) && (lat <= 90)
                                        && (-180 <= lng) && (lng <= 180);
                            }
                        }
                    }
                }
            }
        })
        .find('[name="address"]')
            .on('input keyup', function(e) {
                // Reset lat, lng
                $('#addressForm')
                    .formValidation('updateStatus', 'address', 'NOT_VALIDATED')
                    .find('[name="lat"], [name="lng"]').val('').end();
            })
            .geocomplete({
                details: '#addressDetails',
                map: '#map',
                blur: true,
                restoreValueAfterBlur: true
            })
            .on('geocode:result', function(e, result) {
                $('#addressForm').formValidation('revalidateField', 'address');
            })
            .on('geocode:error', function(e, result) {
                $('#addressForm').formValidation('revalidateField', 'address');
            })
            .end();
}