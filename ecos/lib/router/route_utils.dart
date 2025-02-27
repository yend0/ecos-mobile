enum PAGES {
  root,
  home,
  profile,
  recycle,
  account,
  history,
  knowledgeBase,
  knowledgeDetail,
  localization,
  login,
  register,
}

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.home:
        return "/home";
      case PAGES.profile:
        return "/profile";
      case PAGES.recycle:
        return "/recycle";
      case PAGES.login:
        return "/sign-in";
      case PAGES.register:
        return "/sign-up";
      case PAGES.account:
        return "account";
      case PAGES.localization:
        return "localization";
      case PAGES.history:
        return "history";
      case PAGES.knowledgeBase:
        return "knowledge-base";
      case PAGES.knowledgeDetail:
        return "knowledge-detail";
      default:
        return "/";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.home:
        return "HOME";
      case PAGES.profile:
        return "PROFILE";
      case PAGES.recycle:
        return "RECYCLE";
      case PAGES.login:
        return "SIGN-IN";
      case PAGES.register:
        return "SIGN-UP";
      case PAGES.account:
        return "ACCOUNT";
      case PAGES.localization:
        return "LOCALIZATION";
      case PAGES.history:
        return "HISTROY";
      case PAGES.knowledgeBase:
        return "KNOWLEDGE BASE";
      case PAGES.knowledgeDetail:
        return "KNOWLEDGE DETAIL";
      default:
        return "ROOT";
    }
  }
}
