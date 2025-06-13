class Seller {
  final String name;
  final String phone;
  final String businessName;
  final String province;

  Seller(this.name, this.phone, this.businessName, this.province);

  @override
  String toString() {
    return 'Seller(name: $name, phone: $phone, businessName: $businessName, province: $province)';
  }
}

List<Seller> sellers = [];