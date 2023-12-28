import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HtmlFormatter {
  static html.MutationObserver? _mutationObserver;

  static void format() {
    if (kIsWeb) {
      _mutationObserver = html.MutationObserver(
          (List<dynamic> mutations, html.MutationObserver observer) => _translateHack());
      WidgetsBinding.instance!.addPostFrameCallback((_) => _translateHack());
    }
  }

  static String getNotifID() {
    var data = html.window.localStorage['notification_id'];
    return data == null ? "" : data;
  }

  static bool getNavVer() {
    String? browser = html.window.localStorage['nav_ver'];
    if (browser != null)
      browser = browser.toLowerCase();
    else
      return false;
    if (browser.startsWith("chrome")) {
      int verNum = int.parse(browser.substring(browser.indexOf(" ") + 1));
      if (verNum < 80)
        return true;
      else
        return false;
    } else
      return false;
  }

  static String getQR() {
    var data = html.window.localStorage['qr'];
    return data == null ? "" : data;
  }

  static void resetQR() {
    html.window.localStorage['qr'] = "";
  }

  static void openPage(String url) {
    js.context.callMethod("open", [url, "_self"]);
  }

  static void reload() {
    html.window.location.reload();
  }

  static bool isDesktop() {
    if (html.window.navigator.userAgent.contains("Android") ||
        html.window.navigator.userAgent.contains("webOS") ||
        html.window.navigator.userAgent.contains("iPhone") ||
        html.window.navigator.userAgent.contains("iPad") ||
        html.window.navigator.userAgent.contains("iPod") ||
        html.window.navigator.userAgent.contains("BlackBerry") ||
        html.window.navigator.userAgent.contains("Windows Phone")) {
      return false;
    } else {
      return true;
    }
  }

  static void _translateHack() async {
    List<html.Node> nodes = html.window.document.getElementsByTagName("*");

    for (html.Node node in nodes) {
      _mutationObserver!.observe(node, childList: true);
      html.Element el = node as html.Element;
      if (el.style.transform.isEmpty) continue;
      if (!el.style.transform.contains("\.")) continue;
      el.style.transform = _normalizeTranslate(el.style.transform);
    }
  }

  static String _normalizeTranslate(String value) {
    if (value.length > 12) {
      if (value.substring(0, 10) == "translate(") {
        String p = value.replaceFirst("translate(", "").replaceFirst(")", "").replaceAll("px", "");
        List<String> m = p.split(", ");
        return "translate(" +
            (double.parse(m[0]).toInt()).toString() +
            "px, " +
            (double.parse(m[1]).toInt()).toString() +
            "px)";
      } else if (value.substring(0, 12) == "translate3d(") {
        String p =
            value.replaceFirst("translate3d(", "").replaceFirst(")", "").replaceAll("px", "");
        List<String> m = p.split(", ");
        return "translate3d(" +
            (double.parse(m[0]).toInt()).toString() +
            "px, " +
            (double.parse(m[1]).toInt()).toString() +
            "px, " +
            double.parse(m[2]).toInt().toString() +
            "px)";
      }
    }
    return value;
  }
}
