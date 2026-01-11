import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/bloc/socket/socket_cubit.dart';

/// Modern socket status bar for DriverHome screen
class DriverSocketStatusBar extends StatefulWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onTap;

  const DriverSocketStatusBar({
    super.key,
    this.onRetry,
    this.onTap,
  });

  @override
  State<DriverSocketStatusBar> createState() => _DriverSocketStatusBarState();
}

class _DriverSocketStatusBarState extends State<DriverSocketStatusBar>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketCubit, SocketState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimation,
              child: _buildStatusBar(state),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusBar(SocketState state) {
    final statusInfo = _getStatusInfo(state);
    
    // Only show the bar if there's an issue or it's connecting
    if (state is SocketConnected) {
      _slideController.reverse();
      return const SizedBox.shrink();
    } else {
      _slideController.forward();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: statusInfo.gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: statusInfo.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap ?? () => _showStatusDetails(context, state),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildStatusIcon(state),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        statusInfo.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      if (statusInfo.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          statusInfo.subtitle!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (state is SocketError || state is SocketDisconnected) ...[
                  _buildRetryButton(),
                ],
                const SizedBox(width: 8),
                const Icon(
                  Icons.info_outline,
                  color: Colors.white70,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(SocketState state) {
    switch (state.runtimeType) {
      case SocketConnecting:
        return _buildConnectingIcon();
      case SocketError:
        return _buildErrorIcon();
      case SocketDisconnected:
        return _buildDisconnectedIcon();
      default:
        return _buildInitialIcon();
    }
  }

  Widget _buildConnectingIcon() {
    _pulseController.repeat(reverse: true);
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Center(
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorIcon() {
    _pulseController.stop();
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 16,
      ),
    );
  }

  Widget _buildDisconnectedIcon() {
    _pulseController.stop();
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Icon(
        Icons.wifi_off,
        color: Colors.grey,
        size: 16,
      ),
    );
  }

  Widget _buildInitialIcon() {
    _pulseController.stop();
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Icon(
        Icons.wifi,
        color: Colors.blue,
        size: 16,
      ),
    );
  }

  Widget _buildRetryButton() {
    return GestureDetector(
      onTap: widget.onRetry ?? () => context.read<SocketCubit>().forceReconnect(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  StatusInfo _getStatusInfo(SocketState state) {
    switch (state.runtimeType) {
      case SocketConnecting:
        return StatusInfo(
          title: 'Connecting to Server',
          subtitle: 'Establishing secure connection...',
          gradientColors: [Colors.orange.shade400, Colors.orange.shade600],
          shadowColor: Colors.orange.withOpacity(0.3),
        );
      case SocketError:
        final error = state as SocketError;
        return StatusInfo(
          title: 'Connection Error',
          subtitle: error.message,
          gradientColors: [Colors.red.shade400, Colors.red.shade600],
          shadowColor: Colors.red.withOpacity(0.3),
        );
      case SocketDisconnected:
        return StatusInfo(
          title: 'Disconnected',
          subtitle: 'Lost connection to server',
          gradientColors: [Colors.grey.shade500, Colors.grey.shade700],
          shadowColor: Colors.grey.withOpacity(0.3),
        );
      default:
        return StatusInfo(
          title: 'Initializing',
          subtitle: 'Setting up connection...',
          gradientColors: [Colors.blue.shade400, Colors.blue.shade600],
          shadowColor: Colors.blue.withOpacity(0.3),
        );
    }
  }

  void _showStatusDetails(BuildContext context, SocketState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              _buildStatusIcon(state),
              const SizedBox(height: 16),
              Text(
                _getStatusInfo(state).title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getStatusInfo(state).subtitle ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<SocketCubit>().forceReconnect();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusInfo {
  final String title;
  final String? subtitle;
  final List<Color> gradientColors;
  final Color shadowColor;

  StatusInfo({
    required this.title,
    this.subtitle,
    required this.gradientColors,
    required this.shadowColor,
  });
}

/// Compact socket status indicator for app bars
class CompactDriverSocketStatus extends StatelessWidget {
  const CompactDriverSocketStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketCubit, SocketState>(
      builder: (context, state) {
        if (state is SocketConnected) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(state).withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _getStatusText(state),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(SocketState state) {
    switch (state.runtimeType) {
      case SocketConnecting:
        return Colors.orange;
      case SocketError:
        return Colors.red;
      case SocketDisconnected:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  String _getStatusText(SocketState state) {
    switch (state.runtimeType) {
      case SocketConnecting:
        return 'Connecting';
      case SocketError:
        return 'Error';
      case SocketDisconnected:
        return 'Offline';
      default:
        return 'Init';
    }
  }
}
