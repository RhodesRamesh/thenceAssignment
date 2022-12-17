class ResponseEntity {
  ResponseEntity(
      this.data);

  List data;

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory ResponseEntity.fromMap(Map<String, dynamic> map) {
    return ResponseEntity(
      map['data'] as List,
    );
  }
}