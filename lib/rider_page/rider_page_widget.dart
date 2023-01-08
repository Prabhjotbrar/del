import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../user_location_page/user_location_page_widget.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RiderPageWidget extends StatefulWidget {
  const RiderPageWidget({Key? key}) : super(key: key);

  @override
  _RiderPageWidgetState createState() => _RiderPageWidgetState();
}

class _RiderPageWidgetState extends State<RiderPageWidget> {
  LatLng? currentUserLocationValue;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Rider',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
            child: StreamBuilder<List<RideRecord>>(
              stream: queryRideRecord(
                queryBuilder: (rideRecord) =>
                    rideRecord.where('is_driver_assigned', isEqualTo: false),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                List<RideRecord> listViewRideRecordList = snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewRideRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewRideRecord =
                        listViewRideRecordList[listViewIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF434040),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.person_pin_circle_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                    child: Text(
                                      listViewRideRecord.userName!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                              child: Container(
                                width: double.infinity,
                                height: 30,
                                child: custom_widgets.UserLocationDetails(
                                  width: double.infinity,
                                  height: 30,
                                  fontSize: 16.0,
                                  iOSGoogleMapsApiKey:
                                      'AIzaSyCV3HaLkTEa66rVXTk9QjGSntzZU-pOKrA',
                                  androidGoogleMapsApiKey:
                                      'AIzaSyCV3HaLkTEa66rVXTk9QjGSntzZU-pOKrA',
                                  webGoogleMapsApiKey:
                                      'AIzaSyCV3HaLkTEa66rVXTk9QjGSntzZU-pOKrA',
                                  startCoordinate: currentUserLocationValue!,
                                  endCoordinate:
                                      listViewRideRecord.userLocation!,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  currentUserLocationValue =
                                      await getCurrentUserLocation(
                                          defaultLocation: LatLng(0.0, 0.0));

                                  final rideUpdateData = createRideRecordData(
                                    driverUid: currentUserUid,
                                    driverLocation: currentUserLocationValue,
                                    driverName: currentUserDisplayName,
                                    isDriverAssigned: true,
                                  );
                                  await listViewRideRecord.reference
                                      .update(rideUpdateData);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserLocationPageWidget(
                                        rideDetailsReference:
                                            listViewRideRecord.reference,
                                      ),
                                    ),
                                  );
                                },
                                text: 'Confirm Ride',
                                icon: FaIcon(
                                  FontAwesomeIcons.car,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.white,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
