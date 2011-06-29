function alternateTableRowsColor(id){
  if(document.getElementsByTagName){
    var table = document.getElementById(id);
    var rows = table.getElementsByTagName("tr");
    for(i = 0; i < rows.length; i++){
  //manipulate rows <br>
      if(i % 2 == 0){
        rows[i].className = "even_line";
      }else{
        rows[i].className = "odd_line";
      }
    }
  }
}