abstract class Usecase<Type, Param> {
  const Usecase();
  Future<Type> call(Param param);
}

abstract class Param {}

class NoParam extends Param {}
