enum ApiPaths { temp }

class APIPathProvider {
  static String getPath(ApiPaths path) {
    switch (path) {
      case ApiPaths.temp:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
