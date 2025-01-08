class PetModels {
  final int id;
  final String namahewan, jenis;
  final int harga;

  PetModels({
    required this.id,
    required this.namahewan,
    required this.jenis,
    required this.harga,
  });

  factory PetModels.fromJson(Map<String, dynamic> json) {
  return PetModels(
    id: json['id'],
    namahewan: json['nama_hewan'],
    jenis: json['jenis'],
    harga: json['harga'],
  );
}
  Map<String, dynamic> toJson() => {
        'nama_hewan': namahewan,
        'jenis': jenis,
        'harga': harga,
      };
}
