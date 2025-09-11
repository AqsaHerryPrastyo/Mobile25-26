void main(List<String> args) {
  int angka = 0;
  while (angka <=201){
    bool isPrima = true;
    if (angka < 2) {
      isPrima = false;
    } else {
      for (int i = 2; i <= angka ~/ 2; i++) {
      if (angka % i == 0) {
        isPrima = false;
        break;
      }
      }
    }
    if (isPrima) {
      print("$angka \nNIM: 2341720153 \nNama: Aqsa Herry Prastyo");
    }else if (!isPrima){
      print("$angka");
    }
    angka++;
  }
}
