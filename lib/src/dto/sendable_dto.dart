abstract class SendableDto {
  final String id;
  final String senderId;
  final String receiverId;
  final DateTime createdAt;
  final DateTime? sentAt;
  final DateTime? retrievedAt;

  const SendableDto(this.id, this.senderId, this.receiverId, this.createdAt,
      this.sentAt, this.retrievedAt);
}
