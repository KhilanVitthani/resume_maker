class resumeModel {
  String? about;
  String? address;
  String? contact;
  String? education;
  String? email;
  String? experience;
  String? designation;
  String? exspertise;
  String? firstName;
  int? frame;
  String? image;
  String? lastName;
  String? project;
  List<String>? skillList;
  String? uId;

  resumeModel(
      {this.about,
      this.address,
      this.contact,
      this.education,
      this.email,
      this.experience,
      this.designation,
      this.exspertise,
      this.firstName,
      this.frame,
      this.image,
      this.lastName,
      this.project,
      this.skillList,
      this.uId});

  resumeModel.fromJson(Map<String, dynamic> json) {
    about = json['About'];
    address = json['Address'];
    contact = json['Contact'];
    education = json['Education'];
    email = json['Email'];
    experience = json['Experience'];
    designation = json['designation'];
    exspertise = json['exspertise'];
    firstName = json['first_name'];
    frame = json['frame'];
    image = json['image'];
    lastName = json['last_name'];
    project = json['project'];
    skillList = json['skillList'].cast<String>();
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['About'] = this.about;
    data['Address'] = this.address;
    data['Contact'] = this.contact;
    data['Education'] = this.education;
    data['Email'] = this.email;
    data['Experience'] = this.experience;
    data['designation'] = this.designation;
    data['exspertise'] = this.exspertise;
    data['first_name'] = this.firstName;
    data['frame'] = this.frame;
    data['image'] = this.image;
    data['last_name'] = this.lastName;
    data['project'] = this.project;
    data['skillList'] = this.skillList;
    data['uId'] = this.uId;
    return data;
  }
}
