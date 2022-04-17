import 'package:amigoapp/src/dto/message_token_dto.dart';
import 'package:amigoapp/src/dto/multi_message_dto.dart';
import 'package:chopper/chopper.dart';

part 'message_api_service.chopper.dart';

@ChopperApi(baseUrl: '/messages')
abstract class MessageApiService extends ChopperService {
  static MessageApiService create([ChopperClient? client]) =>
      _$MessageApiService(client);

  @Post(path: '/')
  @Multipart()
  Future<Response<MultiMessageDto>> postMessage(
      @Query() String receiverId, @Part() String text);

  @Get(path: '/{id}')
  Future<Response<MessageTokenDto>> getMessage(@Path() String id);

  @Get(path: '/sent')
  Future<Response<List<MessageTokenDto>>> getSentMessages();

  @Get(path: '/received')
  Future<Response<List<MessageTokenDto>>> getReceivedMessages();
}
