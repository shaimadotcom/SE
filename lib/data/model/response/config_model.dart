import '../language_model.dart';

class ConfigModel {
  String? _systemDefaultCurrency;
  bool? _digitalPayment;
  String? _aboutUs;
  String? _privacyPolicy;
  List<Faq>? _faq;
  List<Companies>? _companies;
  List<Cities>? _cities;
  String? _termsConditions;
  List<CurrencyList>? _currencyList;
  String? _currencySymbolPosition;
  bool? _maintenanceMode;
  List<Language>? _language;
  List<String>? _unit;
  String? _currencyModel;
  bool? _phoneVerification;
  String? _countryCode;
  String? _forgetPasswordVerification;
  String? _version;
  PaymentMethods? _paymentMethods;
  String? _shareUrl;
  ConfigModel(
      {String? systemDefaultCurrency,
        bool? digitalPayment,
        String? aboutUs,
        String? privacyPolicy,
        List<Faq>? faq,
        List<Companies>? companies,
        List<Cities>? cities,
        String? termsConditions,
        List<CurrencyList>? currencyList,
        String? currencySymbolPosition,
        bool? maintenanceMode,
        List<Language>? language,
        List<String>? unit,
        String? currencyModel,
        bool? phoneVerification,
        String? countryCode,
        String? forgetPasswordVerification,
        String? version,
        PaymentMethods? paymentMethods,
        String? shareUrl

      }) {
    _companies=companies;
    _cities=cities;
    _systemDefaultCurrency = systemDefaultCurrency;
    _digitalPayment = digitalPayment;
    _aboutUs = aboutUs;
    _privacyPolicy = privacyPolicy;
    _faq = faq;
    _shareUrl=shareUrl;
    _termsConditions = termsConditions;
    _currencyList = currencyList;
    _currencySymbolPosition = currencySymbolPosition;
    _maintenanceMode = maintenanceMode;
    _language = language;
    _unit = unit;
    _currencyModel = currencyModel;
    _phoneVerification = phoneVerification;
    _countryCode = countryCode;
    _forgetPasswordVerification = forgetPasswordVerification;
    _version = version;
    if (paymentMethods != null) {
      _paymentMethods = paymentMethods;
    }
  }

  String? get systemDefaultCurrency => _systemDefaultCurrency;
  bool? get digitalPayment => _digitalPayment;
  String? get aboutUs => _aboutUs;
  String? get privacyPolicy => _privacyPolicy;
  List<Faq>? get faq => _faq;
  List<Companies>? get companies => _companies;
  List<Cities>? get cities => _cities;
  String? get termsConditions => _termsConditions;
  List<CurrencyList>? get currencyList => _currencyList;
  String? get currencySymbolPosition => _currencySymbolPosition;
  bool? get maintenanceMode => _maintenanceMode;
  List<Language>? get language => _language;
  List<String>? get unit => _unit;
  String? get currencyModel => _currencyModel;
  bool? get phoneVerification => _phoneVerification;
  String? get countryCode =>_countryCode;
  String? get forgetPasswordVerification => _forgetPasswordVerification;
  String? get version => _version;
  PaymentMethods? get paymentMethods => _paymentMethods;
  String? get shareUrl => _shareUrl;

  ConfigModel.fromJson(Map<String, dynamic> json) {
    //logger.i(json);
    _shareUrl=json['share_url'];
    _systemDefaultCurrency = json['system_default_currency'];
    _digitalPayment = json['digital_payment'];
    _aboutUs = json['about_us'];
    _privacyPolicy = json['privacy_policy'];
    if (json['faq'] != null) {
      _faq = [];
      json['faq'].forEach((v) {_faq!.add(Faq.fromJson(v));
      });
    }
    if (json['companies'] != null) {
      _companies = [];
      json['companies'].forEach((v) {_companies!.add(Companies.fromJson(v)); });
    }
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {_cities!.add(Cities.fromJson(v)); });
    }
    _termsConditions = json['terms_&_conditions'];
    if (json['currency_list'] != null) {
      _currencyList = [];
      json['currency_list'].forEach((v) {_currencyList!.add(CurrencyList.fromJson(v));
      });
    }
    _currencySymbolPosition = json['currency_symbol_position'];
    _maintenanceMode = json['maintenance_mode'];
    if (json['language'] != null) {
      _language = [];
      json['language'].forEach((v) {_language!.add(Language.fromJson(v));
      });
    }
    //_unit = json['unit'].cast<String>();
    _currencyModel = json['currency_model'];
    _phoneVerification = json['phone_verification'];
    _countryCode = json['country_code'];
    // if (json['social_login'] != null) {
    //   _socialLogin = [];
    //   json['social_login'].forEach((v) { _socialLogin!.add(SocialLogin.fromJson(v)); });
    // }
    _forgetPasswordVerification = json['forgot_password_verification'];
    if(json['software_version'] != null){
      _version = json['software_version'];
    }
    _paymentMethods = json['payment_methods'] != null
        ? PaymentMethods.fromJson(json['payment_methods'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['share_url']=_shareUrl;
    data['system_default_currency'] = _systemDefaultCurrency;
    data['digital_payment'] = _digitalPayment;
    data['about_us'] = _aboutUs;
    data['privacy_policy'] = _privacyPolicy;
    if (_faq != null) {
      data['faq'] = _faq!.map((v) => v.toJson()).toList();
    }
    if (_companies != null) {
      data['companies'] = _companies!.map((v) => v.toJson()).toList();
    }
    if (_cities != null) {
      data['cities'] = _cities!.map((v) => v.toJson()).toList();
    }
    data['terms_&_conditions'] = _termsConditions;
    if (_currencyList != null) {
      data['currency_list'] =
          _currencyList!.map((v) => v.toJson()).toList();
    }
     data['currency_symbol_position'] = _currencySymbolPosition;
     data['maintenance_mode'] = _maintenanceMode;
    if (_language != null) {
      data['language'] =
          _language!.map((v) => v.toJson()).toList();
    }
    data['unit'] = _unit;
    data['currency_model'] = _currencyModel;
    data['phone_verification'] = _phoneVerification;
    data['country_code'] = _countryCode;
    data['forgot_password_verification'] = _forgetPasswordVerification;
    if (_version != null) {
      data['software_version'] = _version;
    }
    if (_paymentMethods != null) {
      data['payment_methods'] = _paymentMethods!.toJson();
    }
    return data;
  }
}

class SocialLogin {
  String? _loginMedium;
  bool? _status;

  SocialLogin({String? loginMedium, bool? status}) {
    _loginMedium = loginMedium;
    _status = status;
  }

  String? get loginMedium => _loginMedium;
  bool? get status => _status;

  SocialLogin.fromJson(Map<String, dynamic> json) {
    _loginMedium = json['login_medium'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_medium'] = _loginMedium;
    data['status'] = _status;
    return data;
  }
}

class Faq {
  int? _id;
  String? _question;
  String? _answer;
  int? _ranking;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  Faq(
      {int? id,
        String? question,
        String? answer,
        int? ranking,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    _id = id;
    _question = question;
    _answer = answer;
    _ranking = ranking;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  int? get ranking => _ranking;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  Faq.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _ranking = json['ranking'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['question'] = _question;
    data['answer'] = _answer;
    data['ranking'] = _ranking;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class CurrencyList {
  int? _id;
  String? _name;
  String? _symbol;
  String? _code;
  double? _exchangeRate;
  int? _status;
  String? _createdAt;
  String? _updatedAt;

  CurrencyList(
      {int? id,
        String? name,
        String? symbol,
        String? code,
        double? exchangeRate,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    _id = id;
    _name = name;
    _symbol = symbol;
    _code = code;
    _exchangeRate = exchangeRate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get name => _name;
  String? get symbol => _symbol;
  String? get code => _code;
  double? get exchangeRate => _exchangeRate;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  CurrencyList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _symbol = json['symbol'];
    _code = json['code'];
    _exchangeRate = json['exchange_rate'].toDouble();
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['symbol'] = _symbol;
    data['code'] = _code;
    data['exchange_rate'] = _exchangeRate;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class PaymentMethods {
  bool? _syriatelCash;
  bool? _mtnCash;
  PaymentMethods(
      {
        bool? syriatelPayment,
        bool? mtnPayment,
       }) {

    if (syriatelPayment != null) {
      _syriatelCash = syriatelPayment;
    }
    if (mtnPayment != null) {
      _mtnCash = mtnPayment;
    }
  }


  bool? get syriatelPayment => _syriatelCash;
  bool? get mtnPayment => _mtnCash;

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    _syriatelCash = json['SyriatelCash'];
    _mtnCash = json['MTNCash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SyriatelCash'] = _syriatelCash;
    data['MTNCash'] = _mtnCash;
    return data;
  }
}

class Cities{
  int? id;
  String? enName;
  String? arName;
  int? status;
  String? createdAt;
  String? updatedAt;

  Cities(
      {this.id,
        this.enName,
        this.arName,
        this.status,
        this.createdAt,
        this.updatedAt});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    arName = json['ar_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
class Companies {
  Company? company;
  List<Points>? points;

  Companies({this.company, this.points});

  Companies.fromJson(Map<String, dynamic> json) {
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  int? id;
  String? opName;
  String? opArName;
  String? opImg;
  int? status;
  int? rate;
  num? agentCommission;
  num? adminCommission;
  String? email;
  String? password;
  String? address;
  String? lats;
  String? longs;
  dynamic bankName;
  dynamic ifscCode;
  dynamic receiptName;
  dynamic accNo;
  String? payId;
  String? upiId;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
        this.opName,
        this.opArName,
        this.opImg,
        this.status,
        this.rate,
        this.agentCommission,
        this.adminCommission,
        this.email,
        this.password,
        this.address,
        this.lats,
        this.longs,
        this.bankName,
        this.ifscCode,
        this.receiptName,
        this.accNo,
        this.payId,
        this.upiId,
        this.createdAt,
        this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opName = json['op_name'];
    opArName = json['op_ar_name'];
    opImg = json['op_img'];
    status = json['status'];
    rate = json['rate'];
    agentCommission = json['agent_commission'];
    adminCommission = json['admin_commission'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
    lats = json['lats'];
    longs = json['longs'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    receiptName = json['receipt_name'];
    accNo = json['acc_no'];
    payId = json['pay_id'];
    upiId = json['upi_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['op_name'] = opName;
    data['op_ar_name'] = opArName;
    data['op_img'] = opImg;
    data['status'] = status;
    data['rate'] = rate;
    data['agent_commission'] = agentCommission;
    data['admin_commission'] = adminCommission;
    data['email'] = email;
    data['password'] = password;
    data['address'] = address;
    data['lats'] = lats;
    data['longs'] = longs;
    data['bank_name'] = bankName;
    data['ifsc_code'] = ifscCode;
    data['receipt_name'] = receiptName;
    data['acc_no'] = accNo;
    data['pay_id'] = payId;
    data['upi_id'] = upiId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Points {
  int? id;
  int? companyId;
  int? cityId;
  String? title;
  String? arTitle;
  String? address;
  int? status;
  String? mobile;
  dynamic createdAt;
  dynamic updatedAt;
  Cities? city;

  Points(
      {this.id,
        this.companyId,
        this.cityId,
        this.title,
        this.arTitle,
        this.address,
        this.status,
        this.mobile,
        this.createdAt,
        this.updatedAt,
        this.city});

  Points.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    cityId = json['city_id'];
    title = json['title'];
    arTitle = json['ar_title'];
    address = json['address'];
    status = json['status'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? Cities.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['city_id'] = cityId;
    data['title'] = title;
    data['ar_title'] = arTitle;
    data['address'] = address;
    data['status'] = status;
    data['mobile'] = mobile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}