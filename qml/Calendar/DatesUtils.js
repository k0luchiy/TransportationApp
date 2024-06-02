//function dateRangeToString(startDate, endDate) {
//    return startDate.toLocaleDateString('en-US', {year: 'numeric', month: '2-digit', day: '2-digit'})
//    //var start = startDate.getMonth()
//}

function getMonthName(monthInd){
    var monthNames = [ "January", "February", "March", "April", "May", "June",
                           "July", "August", "September", "October", "November", "December" ];
    return monthNames[monthInd];
}

function get30Years(year){
    var years = []
    for(var i=-30; i < 30; ++i){
        years.push(i + year)
    }
    return years
}

function getPureDate(date){
    return new Date(date.getFullYear(), date.getMonth(), date.getDate())
}

function formatDate(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;

    day = day < 10 ? '0' + day : day;
    month = month < 10 ? '0' + month : month;

    return day + '.' + month;
}


function dateRangeToString(startDate, endDate) {
    if(isNaN(startDate) || isNaN(endDate)){
        return ""
    }
    var startFormatted = formatDate(startDate);
    var endFormatted = formatDate(endDate);
    return startFormatted + " - " + endFormatted;
}
