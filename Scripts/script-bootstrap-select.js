$(document).ready(function () {
    // Enable Live Search.
    $('#IncidentTypes').attr('data-live-search', true);

    $('.selectIncident').selectpicker(
        {
            width: '100%',
            title: '- [Choose Incident] -',
            style: 'btn-warning',
            size: 6
        });
});