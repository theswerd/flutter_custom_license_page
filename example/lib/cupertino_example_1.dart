import 'package:example/flutter_custom_license_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

CustomLicensePage cupertinoExample1 = CustomLicensePage((context, licenseData) {
  print("CONNECTION STATE: ${licenseData.connectionState}");
  return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text("Licenses"),
    ),
    child: body(licenseData, context),
  );
});

Widget body(
    AsyncSnapshot<LicenseData> licenseDataFuture, BuildContext context) {
  switch (licenseDataFuture.connectionState) {
    case ConnectionState.done:
      LicenseData? licenseData = licenseDataFuture.data;
      return ListView(
        children: [
          ...licenseDataFuture.data!.packages.map(
                (currentPackage) => CupertinoButton(
              child: Text(
                currentPackage,
              ),
              onPressed: () {
                List<LicenseEntry> packageLicenses = licenseData!
                    .packageLicenseBindings[currentPackage]!
                    .map((binding) => licenseData.licenses[binding]).toList();
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) {
                    return CupertinoPageScaffold(
                      navigationBar: CupertinoNavigationBar(
                        middle: Text(
                          currentPackage,
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: packageLicenses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              packageLicenses[index].paragraphs.map((paragraph) => paragraph.text).join("\n"),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      );

    default:
      return Center(
        child: CupertinoActivityIndicator(),
      );
  }
}
