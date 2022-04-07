

import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({ Key? key }) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  bool checkedValue = false;
  String _selectedGender = "male";
  List<String> dropdownList = ["Senin","Selasa","Rabu","Kamis","Jumat","Sabtu","Minggu"];
  var selectedDropDrown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Column(
          children: [
            Text("Contoh Check Box"),
            CheckboxListTile( 
              title: Text("Setuju"),
              value: checkedValue,
              onChanged: (newValue) {
                setState(() {
                  checkedValue = newValue!;
                  print("newValue");
                });
          
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 16),
            Text("Contoh Radio Button"),
            ListTile(
              leading: Radio<String>(
                value: 'male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              title: const Text("Female")
            ),
            SizedBox(height: 16,),
            Text("Contoh Dropdown"),
            DropdownButton(
              isExpanded: true,
              hint: Text("Silahkan pilih hari"),
              value: selectedDropDrown,
              onChanged: (newValue) {
                setState(() {
                  print(newValue.toString());
                  selectedDropDrown = newValue;
                });
              },
              items: dropdownList.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      )
    );
  }
}