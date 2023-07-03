<!DOCTYPE html>
<html>
<head>
    <title>Excel Like Table</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
        }
        #tableContainer {
            width: 100%;
            height: 100%;
            overflow: auto;
        }
        table {
            width: 100%;
        }
        th {
            background-color: bisque;
        }
        .blue-background {
            background-color: blue;
        }
    </style>
</head>
<body>
    <div id="tableContainer"></div>

<script>
$(document).ready(function() {
    var headers = ['Name', 'Age', 'Address', 'Email', 'Phone', 'Country', 'City', 'Gender', 'Job', 'Company',
                   'School', 'University', 'Degree', 'Major', 'Minor', 'Status', 'Children', 'Parents', 'Siblings', 'Pets',
                   'Car', 'House', 'Color', 'Food', 'Music', 'Books', 'Movies', 'Sports', 'Hobbies', 'Dreams',
                   'Goals', 'Skills', 'Languages', 'Strengths', 'Weaknesses', 'Values', 'Beliefs', 'Personality', 'Health', 'Fitness', 'Wealth'];

    var table = $('<table></table>').addClass('table table-striped table-bordered table-hover');
    var thead = $('<thead></thead>');
    var tbody = $('<tbody></tbody>');

    var headerRow = $('<tr></tr>');
    headers.forEach(function(header, index) {
        var th = $('<th></th>').text(header);
        if (index >= 24 && index <= 31) { // If it's column 25 to 32, remember arrays start at 0 so we subtract 1
            th.addClass('blue-background');
        }
        headerRow.append(th);
    });
    thead.append(headerRow);

    for(var i = 0; i < 26; i++) {
        var row = $('<tr></tr>');
        headers.forEach(function() {
            var td = $('<td></td>').text('');  // keep the cell data blank
            row.append(td);
        });
        tbody.append(row);
    }

    table.append(thead);
    table.append(tbody);
    
    $('#tableContainer').append(table);
});
</script>

</body>
</html>
