import { Suspense, useState, useEffect, useRef } from "react";
import dynamic from "next/dynamic";
import { useTheme } from "next-themes";

export const saveToLocalStorage = (elements, appState) => {
  try {
    localStorage.setItem(
      STORAGE_KEYS.LOCAL_STORAGE_ELEMENTS,
      JSON.stringify(clearElementsForLocalStorage(elements))
    );
    localStorage.setItem(
      STORAGE_KEYS.LOCAL_STORAGE_APP_STATE,
      JSON.stringify(clearAppStateForLocalStorage(appState))
    );
  } catch (error) {
    // Unable to access window.localStorage
    console.error(error);
  }
};

export function ExcalidrawPage({
  excalidrawRef,
  exportToCanvasRef,
  changeImage,
}) {
  const [Excalidraw, setExcalidraw] = useState(null);
  const { theme } = useTheme();

  useEffect(() => {
    import("@excalidraw/excalidraw")
      .then((comp) => {
        setExcalidraw(comp.Excalidraw);
        exportToCanvasRef.current = comp.exportToCanvas;
      })
      .catch((e) => {
        console.log("Error while building whiteboard.", e);
      });
  }, []);

  const UIOptions = {
    canvasActions: {
      changeViewBackgroundColor: false,
      clearCanvas: true,
      export: { saveFileToDisk: false },
      loadScene: false,
      saveToActiveFile: false,
      toggleTheme: false,
      saveAsImage: false,
    },
  };

  return (
    <div className=" w-full h-full ">
      <Suspense fallback={<div>loading...</div>}>
        {Excalidraw && (
          <>
            <Excalidraw
              ref={excalidrawRef}
              UIOptions={UIOptions}
              initalData={{ scrollToContent: false, zoom: false }}
              theme={theme}
              initialData={{
                elements: [
                  {
                    type: "rectangle",
                    version: 141,
                    versionNonce: 361174001,
                    isDeleted: false,
                    id: "oDVXy8D6rom3H1-LLH2-f",
                    fillStyle: "hachure",
                    strokeWidth: 1,
                    strokeStyle: "solid",
                    roughness: 1,
                    opacity: 10,
                    angle: 0,
                    x: 100.50390625,
                    y: 93.67578125,
                    strokeColor: "#000000",
                    backgroundColor: "transparent",
                    width: 490,
                    height: 490,
                    seed: 1968410350,
                    groupIds: [],
                  },
                ],
                appState: {
                  zenModeEnabled: true,
                },
                scrollToContent: true,
              }}
            >
              <WelcomeScreen>
                <HintsToolbar />

                <LandingPageCenter>
                  <Heading>
                    <p className="text-4xl"> Welcome to the design house! </p>
                  </Heading>

                  <div className="font-[Virgil] text-sm">
                    <p className="text-gray-400">
                      1. Scribble together a rough idea.
                    </p>
                    <p className="text-gray-400">2. Describe it.</p>
                    <p className="text-gray-400">3. AI-ify it!</p>
                  </div>
                </LandingPageCenter>
              </WelcomeScreen>
            </Excalidraw>
          </>
        )}
      </Suspense>
    </div>
  );
}

const WelcomeScreen = dynamic(
  () => import("@excalidraw/excalidraw").then((mod) => mod.WelcomeScreen),
  {
    ssr: false,
  }
);

const HintsToolbar = dynamic(
  () =>
    import("@excalidraw/excalidraw").then(
      (mod) => mod.WelcomeScreen.Hints.ToolbarHint
    ),
  {
    ssr: false,
  }
);

const LandingPageCenter = dynamic(
  () =>
    import("@excalidraw/excalidraw").then((mod) => mod.WelcomeScreen.Center),
  {
    ssr: false,
  }
);

const Heading = dynamic(
  () =>
    import("@excalidraw/excalidraw").then(
      (mod) => mod.WelcomeScreen.Center.Heading
    ),
  {
    ssr: false,
  }
);
