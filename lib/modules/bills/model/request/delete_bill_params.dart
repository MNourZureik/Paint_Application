class DeleteBillParams{
  final int id;
  DeleteBillParams({required this.id});
  Map<String,dynamic> toMap(){
    return {
      'bill_id':id
    };
  }
}