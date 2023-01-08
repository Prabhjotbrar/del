import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserLocationPageWidget extends StatefulWidget {
  const UserLocationPageWidget({
    Key? key,
    this.rideDetailsReference,
  }) : super(key: key);

  final DocumentReference? rideDetailsReference;

  @override
  _UserLocationPageWidgetState createState() => _UserLocationPageWidgetState();
}

class _UserLocationPageWidgetState extends State<UserLocationPageWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<RideRecord>(
      stream: RideRecord.getDocument(widget.rideDetailsReference!),
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
        final userLocationPageRideRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
            automaticallyImplyLeading: false,
            title: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'USER LOCATION',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFA1A1A1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            elevation: 4,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: custom_widgets.RouteViewLive(
                      width: double.infinity,
                      height: double.infinity,
                      iOSGoogleMapsApiKey:
                          'AIzaSyCV3HaLkTEa66rVXTk9QjGSntzZU-pOKrA',
                      androidGoogleMapsApiKey:
                          'AIzaSyCV3HaLkTEa66rVXTk9QjGSntzZU-pOKrA',
                      webGoogleMapsApiKey:
                          'AIzaSyCV3HaLkTEa66rVXTk9QjGSntzZU-pOKrA',
                      lineColor: FlutterFlowTheme.of(context).primaryColor,
                      startCoordinate:
                          userLocationPageRideRecord.driverLocation!,
                      endCoordinate: userLocationPageRideRecord.userLocation!,
                      rideDetailsReference:
                          userLocationPageRideRecord.reference,
                      updateInterval: 5,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.person,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 36,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: Text(
                                userLocationPageRideRecord.userName!,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        indent: 16,
                        endIndent: 16,
                        color: Color(0x7FF1F4F8),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              FFAppState().routeDuration,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                              child: Text(
                                'away',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0x7FFFFFFF),
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                FFAppState().routeDistance,
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
