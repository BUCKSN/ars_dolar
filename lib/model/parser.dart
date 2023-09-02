import 'package:html/parser.dart' show parse;

main(List<String> args) {
  parseData();
}

parseData() {
  final document = parse('''
    <div class="weather-item now"><!-- now  -->
   <span class="time">Now</span>
   
    <div class="temp">19.8<span>℃</span>
        <small>(23℃)</small>
    </div>
   
   <table>
       <tr>
           <th><i class="icon01" aria-label="true"></i></th>
           <td>93%</td>
       </tr>
       <tr>
           <th><i class="icon02" aria-label="true"></i></th>
           <td>south 2.2km/h</td>
       </tr>
       <tr>
           <th><i class="icon03" aria-label="true"></i></th>
           <td>-</td>
       </tr>
   </table>
</div>
  ''');

  //declaring a list of String to hold all the data.
  final List<String> data = [];

  data.add(document.getElementsByClassName('time')[0].innerHtml);

  //declaring variable for temp since we will be using it multiple places
  final temp = document.getElementsByClassName('temp')[0];
  data.add(temp.innerHtml.substring(0, temp.innerHtml.indexOf('<span>')));
  data.add(temp
      .getElementsByTagName('small')[0]
      .innerHtml
      .replaceAll(RegExp('[(|)|℃]'), ''));

  //We can also do document.getElementsByTagName("td") but I am just being more specific here.
  final rows =
      document.getElementsByTagName('table')[0].getElementsByTagName('td');

  //Map elememt to its innerHtml,  because we gonna need it.
  //Iterate over all the table-data and store it in the data list
  rows.map((e) => e.innerHtml).forEach((element) {
    if (element != '-') {
      data.add(element);
    }
  });

  //print the data to console.
  print(data);
}
