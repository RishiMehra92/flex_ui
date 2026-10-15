/// String utilities for Flex UI widgets.
class FlexStringHelpers {
  const FlexStringHelpers._();

  /// Inflects a button action label into a progressive loading message.
  ///
  /// For example:
  /// - "Sign In" -> "Signing in..."
  /// - "Submit" -> "Submitting..."
  /// - "Save" -> "Saving..."
  /// - "Delete" -> "Deleting..."
  /// - "Continue" -> "Continuing..."
  static String deriveLoadingText(String? originalText,
      {String? explicitText}) {
    if (explicitText != null && explicitText.isNotEmpty) {
      return explicitText;
    }
    if (originalText == null || originalText.trim().isEmpty) {
      return 'Loading...';
    }

    final lower = originalText.trim().toLowerCase();
    switch (lower) {
      case 'sign in':
      case 'signin':
        return 'Signing in...';
      case 'sign up':
      case 'signup':
        return 'Signing up...';
      case 'log in':
      case 'login':
        return 'Logging in...';
      case 'submit':
        return 'Submitting...';
      case 'save':
        return 'Saving...';
      case 'continue':
        return 'Continuing...';
      case 'create account':
        return 'Creating account...';
      case 'create':
        return 'Creating...';
      case 'verify':
        return 'Verifying...';
      case 'confirm':
        return 'Confirming...';
      case 'reset password':
        return 'Resetting password...';
      case 'send':
        return 'Sending...';
      case 'update':
        return 'Updating...';
      case 'delete':
        return 'Deleting...';
      case 'cancel':
        return 'Cancelling...';
      case 'apply':
        return 'Applying...';
      case 'pay':
        return 'Processing payment...';
      case 'search':
        return 'Searching...';
      case 'download':
        return 'Downloading...';
      case 'upload':
        return 'Uploading...';
    }

    final words = originalText.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return 'Loading...';

    String firstWord = words.first;
    if (firstWord.toLowerCase().endsWith('ee')) {
      firstWord = '${firstWord}ing';
    } else if (firstWord.toLowerCase().endsWith('e') &&
        firstWord.length > 2 &&
        !firstWord.toLowerCase().endsWith('ie')) {
      firstWord = '${firstWord.substring(0, firstWord.length - 1)}ing';
    } else {
      firstWord = '${firstWord}ing';
    }

    if (words.length > 1) {
      return '$firstWord ${words.sublist(1).join(' ')}...';
    }
    return '$firstWord...';
  }
}
