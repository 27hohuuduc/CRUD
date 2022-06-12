<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CRUD.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
                td input{
                    width: 100%
                }
                .fixId {
                    width: 30px
                }
                .fixName{
                    width: 80px;
                    text-align: center
                }

                .fixInfor{
                    width: 55%
                }
             
                .fixBtn{
                    width: 5%
                }
            </style>
</head>
<body style="margin: 30px 10%">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm" EnablePageMethods="true" />
        <div>
            <script type="text/javascript">
                var name; var infor; var editing = false; var IdCompany; var company; var nameS; var editingS = false;
                function getCompany() {
                    PageMethods.getCompany(getData_Success, Fail);
                }
                function getData_Success(msg) {
                    index = msg.length;
                    for (let i = msg.length - 1; i >= 0; i--) {
                        add(msg[i].IdC, msg[i].NameC, msg[i].Infor);
                    }
                }
                function Fail(msg) {
                    alert(msg.get_message());
                }
                $(window).on("load", function () {
                    getCompany();
                });

                function myReload() {
                    $("#company").html("");
                    getCompany();
                    editing = false;
                }

                function addCompany() {
                    name = $("#InputName").val();
                    infor = $("#InputInfor").val();
                    $("#InputName").val('');
                    $("#InputInfor").val('');
                    PageMethods.addCompany(name, infor, addCompany_Success, Fail);
                }

                function addCompany_Success(msg) {
                    add(msg, name, infor);
                }
                function add(id, n, i) {
                    var row = $('<tr id="' + id + '"></tr>');
                    var col1 = $('<td class="fixId">' + id + '</td>');
                    var col2 = $('<td class="fixName">' + n + '</td>');
                    var col3 = $('<td class="fixInfor">' + i + '</td>');
                    var col4 = $('<td class="fixBtn"><input type="button" onclick="getStaff(&#39;' + id + '&#39;,&#39;' + n + '&#39;)" value="Xem" data-toggle="modal" data-target="#exampleModalLong"/></td>');
                    var col5 = $('<td class="fixBtn"><input type="button" onclick="edit(&#39;' + id + '&#39;)" value="Sửa"/></td>');
                    var col6 = $('<td class="fixBtn"><input type="button" onclick="delCompany(&#39;' + id + '&#39;);" value="Xoá"/></td>');
                    row.append(col1, col2, col3, col4, col5, col6).appendTo("#company");
                }
                function delCompany(id) {
                    PageMethods.delCompany(id, delCompany_Success(id), Fail);
                }
                function delCompany_Success(id) {
                    $("#" + id).remove();
                }
                function edit(id) {
                    if (!editing) {
                        editing = true;
                        var CopyName = $("#" + id).children(".fixName").html();
                        var CopyInfor = $("#" + id).children(".fixInfor").html();
                        $("#" + id).children(".fixName").html('<input id="EditName" type="text"/>');
                        $("#" + id).children(".fixInfor").html('<input id="EditInfor" type="text"/>');
                        $("#" + id).children(".fixBtn").remove();
                        $("#" + id).append('<td></td><td class="fixBtn"><input type="button" onclick="editCompany(&#39;' + id + '&#39;)" value="Xong"/></td>'
                            + '<td class= "fixBtn"><input type="button" onclick="refreshRow(&#39;' + id + '&#39;, &#39;' + CopyName + '&#39;, &#39;' + CopyInfor + '&#39;)" value="Huỷ" /></td > ');
                    }
                }
                function refreshRow(id, n, i) {
                    editing = false;
                    $("#" + id).html('<td class="fixId">' + id + '</td><td class="fixName">' + n + '</td>'
                        + '<td class= "fixInfor" > ' + i + '</td > '
                        + '<td class= "fixBtn" > <input type="button" onclick="getStaff(&#39;' + id + '&#39;, &#39;' + n + '&#39;)" value="Xem"  data-toggle="modal" data-target="#exampleModalLong"/></td >'
                        + '<td class="fixBtn"><input type="button" onclick="edit(&#39;' + id + '&#39;)" value="Sửa"/></td>'
                        + '<td class="fixBtn"><input type="button" onclick="delCompany(&#39;' + id + '&#39;);" value="Xoá"/></td>');
                }
                function editCompany(id) {
                    name = $("#EditName").val();
                    infor = $("#EditInfor").val();
                    if (name.trim() === "") {
                        alert("Tên không được để trống.");
                        return;
                    }
                    PageMethods.editCompany(id, name, infor, editCompany_Success(id), Fail);
                }
                function editCompany_Success(id) {
                    refreshRow(id, name, infor);
                }
                function getStaff(id, name) {
                    IdCompany = id
                    company = name;
                    PageMethods.getStaff(id, getStaff_Success, FailS);
                }
                function FailS(msg) {
                    $("#exampleModalLongTitle").html(msg.get_message);
                }
                function getStaff_Success(msg) {
                    $("#exampleModalLongTitle").html("Nhân viên của " + company);
                    $("#staff").html("");
                    for (let i = msg.length - 1; i >= 0; i--) {
                        addS(msg[i].IdS, msg[i].NameS);
                    }
                }
                function addStaff() {
                    nameS = $("#InputNameS").val();
                    $("#InputNameS").val('')
                    PageMethods.addStaff(nameS, IdCompany, addStaff_Success, Fail);
                }
                function addStaff_Success(msg) {
                    addS(msg, nameS);
                }
                function addS(id, n) {
                    var row = $('<tr id="' + id + '"></tr>');
                    var col1 = $('<td class="fixId">' + id + '</td>');
                    var col2 = $('<td class="fixName">' + n + '</td>');
                    var col3 = $('<td class="fixBtn"><input type="button" onclick="editS(&#39;' + id + '&#39;)" value="Sửa"/></td>');
                    var col4 = $('<td class="fixBtn"><input type="button" onclick="delStaff(&#39;' + id + '&#39;);" value="Xoá"/></td>');
                    row.append(col1, col2, col3, col4).appendTo("#staff");
                }
                function delStaff(id) {
                    PageMethods.delStaff(id, delStaff_Success(id), Fail);
                }
                function delStaff_Success(id) {
                    $("#" + id).remove();
                }
                function editS(id) {
                    if (!editingS) {
                        editingS = true;
                        var CopyName = $("#" + id).children(".fixName").html();
                        $("#" + id).children(".fixName").html('<input id="EditNameS" type="text"/>');
                        $("#" + id).children(".fixBtn").remove();
                        $("#" + id).append('<td class="fixBtn"><input type="button" onclick="editStaff(&#39;' + id + '&#39;)" value="Xong"/></td>'
                            + '<td class= "fixBtn"><input type="button" onclick="refreshRowS(&#39;' + id + '&#39;, &#39;' + CopyName + '&#39;)" value="Huỷ" /></td > ');
                    }
                }
                function refreshRowS(id, n) {
                    editingS = false;
                    $("#" + id).html('<td class="fixId">' + id + '</td><td class="fixName">' + n + '</td>'
                        + '<td class="fixBtn"><input type="button" onclick="editS(&#39;' + id + '&#39;)" value="Sửa"/></td>'
                        + '<td class="fixBtn"><input type="button" onclick="delStaff(&#39;' + id + '&#39;);" value="Xoá"/></td>');
                }
                function editStaff(id) {
                    nameS = $("#EditNameS").val();
                    if (nameS.trim() === "") {
                        alert("Tên không được để trống.");
                        return;
                    }
                    PageMethods.editStaff(id, nameS, IdCompany, editStaff_Success(id), Fail);
                }
                function editStaff_Success(id) {
                    refreshRowS(id, nameS);
                }
            </script>
            <div style="position: relative; font-size: 30px; font-weight: bold">
                <div style="display:inline-block; margin-right: 6px">Danh sách công ty</div>
                <button type="button" class="btn btn-default btn-sm" onclick="myReload();">
                  <span class="glyphicon glyphicon-refresh" style="font-size: 15px"></span>
                </button>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Mã</th>
                        <th class="fixName" scope="col">Tên công ty</th>
                        <th class="fixName" scope="col">Thông tin</th>
                    </tr>
                </thead>
                <tbody id="company">
                    <!-- Dữ liệu -->
                    
                </tbody>
                <tbody>
                    <tr>
                        <td></td>
                        <td><input id="InputName" type="text"/></td>
                        <td><input id="InputInfor" type="text"/></td>
                        <td></td>
                        <td><input type="button" onclick="addCompany();" value="Thêm"/></td>
                    </tr>
                </tbody>
            </table>
            <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
              <div class="modal-dialog" style="width: 35%" role="document">
                <div class="modal-content">
                  <div style="position: relative; font-size: 30px; font-weight: bold" class="modal-header">
                    <div style="display:inline-block; margin-right: 6px" class="modal-title" id="exampleModalLongTitle"></div>
                    <button type="button" class="close" data-dismiss="modal">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <div style="padding-bottom: 0px" class="modal-body">
                    <table style="margin: 0px" class="table">
                        <thead>
                            <tr>
                                <th scope="col">Mã</th>
                                <th style="width: 175px; text-align: center" scope="col">Tên nhân viên</th>
                            </tr>
                        </thead>
                        <tbody id="staff">
                            <!-- Dữ liệu -->
                    
                        </tbody>
                        <tbody>
                            <tr>
                                <td></td>
                                <td><input id="InputNameS" type="text"/></td>
                                <td></td>
                                <td><input type="button" onclick="addStaff();" value="Thêm"/></td>
                            </tr>
                        </tbody>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
        </div>
    </form> 
</body>
</html>
