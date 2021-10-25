import 'package:appcripto/models/moeda.dart';
import 'package:hive/hive.dart';

class MoedaHiveAdapter extends TypeAdapter<Moeda> {
  @override
  final typeId = 0;

  @override
  Moeda read(BinaryReader reader) {
    return Moeda(
      icone: reader.readString(),
      nome: reader.readString(),
      sigla: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter write, Moeda moeda) {
    write.write(moeda.icone);
    write.write(moeda.nome);
    write.write(moeda.sigla);
    write.write(moeda.preco);
  }
}
