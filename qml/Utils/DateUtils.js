//function dateRangeToString(startDate, endDate) {
//    return startDate.toLocaleDateString('en-US', {year: 'numeric', month: '2-digit', day: '2-digit'})
//    //var start = startDate.getMonth()
//}

function getMonthName(monthInd){
    var monthNames = [ qsTr("January"), qsTr("February"), qsTr("March"), qsTr("April"), qsTr("May"), qsTr("June"),
                           qsTr("July"), qsTr("August"), qsTr("September"), qsTr("October"), qsTr("November"), qsTr("December")];
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

function strToDate(date){
    var pattern = /(\d{2})\.(\d{2})\.(\d{4})/;
    var newDate = new Date(date.replace(pattern,'$3-$2-$1'));
    return newDate
}

function formatDate(date) {
    if(isNaN(date)){
        return ""
    }
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();

    day = day < 10 ? '0' + day : day;
    month = month < 10 ? '0' + month : month;

    return day + '.' + month + "." + year;
}

function formatPartDateRage(date) {
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
    var startFormatted = formatPartDateRage(startDate);
    var endFormatted = formatPartDateRage(endDate);
    return startFormatted + " - " + endFormatted;
}

