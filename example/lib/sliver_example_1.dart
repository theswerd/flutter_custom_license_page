import 'package:example/flutter_custom_license_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

CustomLicensePage sliverExample1 = CustomLicensePage((context, licenseData) {
  print("CONNECTION STATE: ${licenseData.connectionState}");
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.red,
          title: Text("Licenses"),
        ),
        body(
          licenseData,
          context,
        ),
      ],
    ),
  );
});

Widget body(
    AsyncSnapshot<LicenseData> licenseDataFuture, BuildContext context) {
  switch (licenseDataFuture.connectionState) {
    case ConnectionState.done:
      LicenseData? licenseData = licenseDataFuture.data;
      return SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        children: [
          ...licenseDataFuture.data!.packages.map(
                (currentPackage) => TextButton(
                child: Column(
                  children: [
                    Text(
                      currentPackage,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "${licenseData!.packageLicenseBindings[currentPackage]!.length} Licenses",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle2!.color,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  List<LicenseEntry> packageLicenses = licenseData
                      .packageLicenseBindings[currentPackage]!
                      .map((binding) => licenseData.licenses[binding])
                      .toList();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          body: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                backgroundColor: Colors.red,
                                title: Text(
                                  currentPackage,
                                ),
                              ),
                              SliverFillRemaining(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    25,
                                  ),
                                  child: Text(
                                    packageLicenses
                                        .map(
                                          (e) => e.paragraphs
                                          .map((e) => e.text)
                                          .toList()
                                          .reduce(
                                            (value, element) =>
                                        value + "\n" + element,
                                      ),
                                    )
                                        .reduce(
                                          (value, element) =>
                                      value + "\n\n" + element,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      );

    default:
      return SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }
}
