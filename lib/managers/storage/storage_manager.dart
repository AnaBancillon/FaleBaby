abstract class StorageManager {
  /// Read the [key] from the storage.
  ///
  /// It can receive a [defaultValue] as a parameter.
  /// It can be useful to avoid nullable values.
  Future<dynamic> read(key, {defaultValue});

  /// Deletes the [key] from the storage.
  Future<void> delete(String key);

  /// Deletes all the key from he storage.
  ///
  /// Might be useful to a sign out.
  Future<void> deleteAll();

  /// Writes a [key] with the [value] in the storage.
  Future<void> write(String key, dynamic value);

  /// Checks if the the storage contains the [key].
  Future<bool> contains(String key);
}
