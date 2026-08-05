abstract class ApiResponse<T> {
  const ApiResponse();

  R when<R>({
    required R Function(T data) success,
    required R Function(Exception error) error,
    required R Function() loading,
  });

  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(Exception error)? error,
    R Function()? loading,
    required R Function() orElse,
  });
}

class SuccessResponse<T> extends ApiResponse<T> {
  final T data;
  final String? message;
  final Map<String, dynamic>? metadata;

  const SuccessResponse({
    required this.data,
    this.message,
    this.metadata,
  });

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Exception error) error,
    required R Function() loading,
  }) {
    return success(data);
  }

  @override
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(Exception error)? error,
    R Function()? loading,
    required R Function() orElse,
  }) {
    return success != null ? success(data) : orElse();
  }
}

class ErrorResponse<T> extends ApiResponse<T> {
  final Exception exception;
  final String? message;

  const ErrorResponse({
    required this.exception,
    this.message,
  });

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Exception error) error,
    required R Function() loading,
  }) {
    return error(exception);
  }

  @override
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(Exception error)? error,
    R Function()? loading,
    required R Function() orElse,
  }) {
    return error != null ? error(exception) : orElse();
  }
}

class LoadingResponse<T> extends ApiResponse<T> {
  const LoadingResponse();

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(Exception error) error,
    required R Function() loading,
  }) {
    return loading();
  }

  @override
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(Exception error)? error,
    R Function()? loading,
    required R Function() orElse,
  }) {
    return loading != null ? loading() : orElse();
  }
}

class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final String? nextPageUrl;
  final String? previousPageUrl;

  PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  bool get hasNextPage => nextPageUrl != null;
  bool get hasPreviousPage => previousPageUrl != null;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      data: (json['data'] as List?)
          ?.map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList() ?? [],
      currentPage: json['currentPage'] ?? json['page'] ?? 1,
      pageSize: json['pageSize'] ?? json['perPage'] ?? 10,
      totalItems: json['totalItems'] ?? json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
      nextPageUrl: json['nextPageUrl'] ?? json['next_page_url'],
      previousPageUrl: json['previousPageUrl'] ?? json['prev_page_url'],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'data': data.map((item) => toJsonT(item)).toList(),
      'currentPage': currentPage,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'totalPages': totalPages,
      'nextPageUrl': nextPageUrl,
      'previousPageUrl': previousPageUrl,
    };
  }
}

class ApiResult<T> {
  final T? data;
  final Exception? error;
  final bool isSuccess;

  const ApiResult._({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory ApiResult.success(T data) => ApiResult._(
    data: data,
    isSuccess: true,
  );

  factory ApiResult.error(Exception error) => ApiResult._(
    error: error,
    isSuccess: false,
  );

  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(Exception error) onError,
  }) {
    if (isSuccess && data != null) {
      return onSuccess(data as T);
    } else if (!isSuccess && error != null) {
      return onError(error!);
    }
    throw StateError('Invalid state');
  }

  R? maybeWhen<R>({
    R Function(T data)? onSuccess,
    R Function(Exception error)? onError,
  }) {
    if (isSuccess && data != null && onSuccess != null) {
      return onSuccess(data as T);
    } else if (!isSuccess && error != null && onError != null) {
      return onError(error!);
    }
    return null;
  }

  @override
  String toString() => isSuccess
      ? 'ApiResult.success($data)'
      : 'ApiResult.error($error)';
}
