enum DioMethod {
  get("GET"),
  post("POST"),
  delete("DELETE"),
  put("PUT");

  final String name;

  const DioMethod(this.name);
}
