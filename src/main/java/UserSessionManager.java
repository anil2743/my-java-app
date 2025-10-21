import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ConcurrentHashMap;

public class UserSessionManager {
    private static final ConcurrentHashMap<String, HttpSession> activeSessions = new ConcurrentHashMap<>();

    static {
        // Initialize the ConcurrentHashMap
    }

    public UserSessionManager() {
        super();
    }

    public static synchronized void registerSession(String email, HttpSession session) {
        HttpSession existingSession = activeSessions.remove(email);
        if (existingSession != null) {
            try {
                existingSession.invalidate();
            } catch (IllegalStateException e) {
                // Ignore exception if session is already invalidated
            }
        }
        activeSessions.put(email, session);
    }

    public static synchronized void removeSession(String email) {
        activeSessions.remove(email);
    }

    public static synchronized HttpSession getSession(String email) {
        return activeSessions.get(email);
    }
}